using System.Collections;
using LibNoise;
using System.IO;
using System;
using LibNoise.Generator;
using LibNoise.Operator;
using UnityEngine;

public enum NoiseType {Perlin, Billow, RiggedMultifractal, Voronoi, Mix};

public class Demo : MonoBehaviour 
{
    private Noise2D m_noiseMap = null;
    private Texture2D[] m_textures = new Texture2D[3];
    public int resolution = 64; 
    public NoiseType noise = NoiseType.Perlin;
    public float zoom = 1f; 
    public float offset = 0f; 
    
    public void Start() 
    {
    	Generate();
    }
    
    public void OnGUI() 
    {
    	int y = 0;
    	foreach (string i in System.Enum.GetNames(typeof(NoiseType))) 
        {
    		if (GUI.Button(new Rect(0,y,100,20), i) ) 
            {
    			noise = (NoiseType) Enum.Parse(typeof(NoiseType), i);
    			Generate();
    		}
    		y+=20;
    	}
    }
    	
    public void Generate() 
    {	
        // Create the module network
        ModuleBase moduleBase;

        //Const white = new Const(1);

        switch(noise) {
	        case NoiseType.Billow:
                Billow blw = new Billow(1,1,10,1,100,QualityMode.High);
                blw.Frequency = 2;
                blw.Lacunarity = 1;
                blw.OctaveCount = 2;
                blw.Persistence = 1;

                Invert inv = new Invert(blw);
                Exponent exp = new Exponent(6,inv);

                moduleBase = exp;
                
                break;
            	
	        case NoiseType.RiggedMultifractal:	
                RidgedMultifractal mul = new RidgedMultifractal();
                mul.Frequency = 2;
                mul.Lacunarity = .1;
                mul.OctaveCount = 1;
                mul.Seed = 1;
                moduleBase = mul; //new RidgedMultifractal();
                break;   
            	
	        case NoiseType.Voronoi:
                Voronoi vor = new Voronoi(4, 0.5, 140, true);
                //vor.Frequency = 1.5;
                //vor.Displacement = 0;
                //moduleBase = vor; // new Scale(1.5, 1.5, 1.5, vor);

                //Abs aaa = new Abs(vor);
                /*
                Curve crv = new Curve(vor);

                crv.Add(0,-1);
                crv.Add(1,0.5);
                crv.Add(2,0.8);
                crv.Add(3,0.9);
                crv.Add(4,1);
                

                //Clamp clp = new Clamp(0, 1, vor);

                Exponent exp = new Exponent(4,crv);

                ScaleBias scb = new ScaleBias(2,1,exp);
                
                //Subtract sb = new Subtract(white,aaa);

                */
                moduleBase = vor;
                //Power pvr = new Power(vor,moduleBase);

                //moduleBase = pvr;

                //Perlin vor = new Perlin(2, 1.5, 50, 1, 240, QualityMode.High);
                //Voronoi vor = new Voronoi(4,.5,140,true);

                //moduleBase = vor; // new Scale(1.5, 1.5, 1.5, vor);
                
                //moduleBase = new Translate(0,0,0,vor);
                //moduleBase = new Clamp(-1,1,vor);

                /*
                var crv = new Curve(vor);
                crv.Add(0,1);
                crv.Add(1,-1);
                crv.Add(2,-1.1);
                crv.Add(3,-1.3);
                crv.Add(4,-1.5);

                //moduleBase = new Subtract(moduleBase,crv);

                //Debug.Log(crv.);
                
                //.Add(0,0);
                //moduleBase = new Curve(vor).Add(1, 0.1);
                //moduleBase = new Curve(vor).Add(2, 1);

                moduleBase = crv;
                */
                break;             	         	
            	
            case NoiseType.Mix:            	
                Perlin perlin = new Perlin();
                perlin.Frequency = 2;
                perlin.Lacunarity = 1;
                perlin.Persistence = 20;
                RidgedMultifractal rigged = new RidgedMultifractal();
                rigged.Frequency = 1;
                rigged.Lacunarity = 5;
                rigged.OctaveCount = 100;
                moduleBase = new Add(perlin, rigged);
                break;
            	
            default:
                Perlin prl = new Perlin();

                prl.Frequency = 3;
                prl.Lacunarity = 3;
                prl.OctaveCount = 4;
                prl.Persistence = 0.5;
                //prl.

                moduleBase = prl;
                break;
            	
        }

        // Initialize the noise map
        this.m_noiseMap = new Noise2D(resolution, resolution, moduleBase);
        this.m_noiseMap.GeneratePlanar(
        offset + -1 * 1/zoom, 
        offset + offset + 1 * 1/zoom, 
        offset + -1 * 1/zoom,
        offset + 1 * 1/zoom);

        // Generate the textures
        this.m_textures[0] = this.m_noiseMap.GetTexture(GradientPresets.Grayscale);
        this.m_textures[0].Apply();

        this.m_textures[1] = this.m_noiseMap.GetTexture(GradientPresets.Terrain);
        this.m_textures[1].Apply();
             
        this.m_textures[2] = this.m_noiseMap.GetNormalMap(3.0f);
		this.m_textures[2].Apply();
			 
		//display on plane
        GetComponent<Renderer>().material.mainTexture = m_textures[0];

        //write images to disk
        File.WriteAllBytes(Application.dataPath + "/../Gray.png", m_textures[0].EncodeToPNG() );
        File.WriteAllBytes(Application.dataPath + "/../Terrain.png", m_textures[1].EncodeToPNG() );
        File.WriteAllBytes(Application.dataPath + "/../Normal.png", m_textures[2].EncodeToPNG() );

        //Debug.Log("Wrote Textures out to "+Application.dataPath + "/../");
    }
    
}