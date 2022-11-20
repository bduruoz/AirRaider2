using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class ConvertTextureToPNG : MonoBehaviour
{
    public Texture2D texture;
    public string fullpath = "";
    public bool specialName = true;
    public string textureName = "";
    public string nm = "";

    public Transform[] objects;

    [Button("Save All objects Texture")]
    public void SaveAllTextures()
    {
        foreach(Transform item in objects)
        {
            texture = item.GetComponent<Renderer>().sharedMaterial.mainTexture as Texture2D;
            nm = item.name;
            specialName = true;
            SaveTexture();
        }
    }

    public static void SaveTextureAsPNG(Texture2D _texture, string _fullPath)
    {
        byte[] _bytes = _texture.EncodeToPNG();
        System.IO.File.WriteAllBytes(_fullPath, _bytes);
        //Debug.Log(_bytes.Length / 1024 + "Kb was saved as: " + _fullPath);
    }

    [Button("Save Texture")]
    public void SaveTexture()
    {
        if(specialName)
        {
            //nm = textureName;
            if(nm == "")
            {
                nm = texture.name.ToString();
            }
        }
        else
        {
            nm = texture.name.ToString();
        }
        //Debug.Log(fullpath + nm + ".png");
        SaveTextureAsPNG(texture, fullpath + nm + ".png");
    }
}
