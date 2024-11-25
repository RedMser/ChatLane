using ValveResourceFormat.Serialization.KeyValues;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

public static class YAMLToKeyValues
{
    public static KVObject Convert(string yaml)
    {
        var ds = new DeserializerBuilder()
            .WithNamingConvention(UnderscoredNamingConvention.Instance)
            .Build();
        
        var config = ds.Deserialize<ConfigRoot>(yaml);
        var vdata = OriginalVData.GetData();
        config.ApplyTo(vdata);
        return vdata;
    }
}

public class ConfigRoot
{
    public string Name { get; set; }
    public Dictionary<string, bool> OverrideBindable { get; set; }
    public List<ConfigCustomMenu> CustomMenus { get; set; }

    public void ApplyTo(KVObject vdata)
    {
        // Override bindables
        foreach (var bindable in OverrideBindable)
        {
            if (vdata.Properties.TryGetValue(bindable.Key, out KVValue cmdValue))
            {
                var cmd = (KVObject)cmdValue.Value;
                if (cmd.Properties.ContainsKey("m_bBindable"))
                {
                    cmd.Properties["m_bBindable"] = WriteBinaryKV3.MakeValue(bindable.Value);
                }
                else
                {
                    cmd.AddProperty("m_bBindable", WriteBinaryKV3.MakeValue(bindable.Value));
                }
            }
            else
            {
                Console.WriteLine($"WARN: override_bindable contains unknown voice command \"{bindable.Key}\".");
            }
        }

        // Append custom menus
        var menuNumber = 1;
        foreach (var menu in CustomMenus)
        {
            var menuData = new Dictionary<object, object> {
                ["m_strLabelToken"] = menu.Name,
                ["m_strMessageToken"] = menu.Name,
                ["m_ePingMarkerInfo"] = "k_EPingMarkerInfo_OnlyPlaySound",
                ["m_ePingConcept"] = "CITADEL_PING_DEFEND_LANE",
                ["m_unPingWheelOptionID"] = menuNumber + 69,
                ["m_bIsSubnavMessage"] = false,
                ["m_eSliceType"] = "CITADEL_PING_WHEEL_SUBNAV_ONE_SLICE",
                ["m_vecSubnavMessageNames"] = menu.Items.ToList<object>(),
                ["m_bBindable"] = true,
            };
            if (!string.IsNullOrEmpty(menu.Icon))
            {
                menuData["m_strIcon"] = "file://{images}/hud/ping/ping_icon_" + menu.Icon + ".svg";
            }
            vdata.AddProperty($"Custom {menuNumber}", WriteBinaryKV3.MakeValue(menuData));
            menuNumber++;
        }
    }
}

public class ConfigCustomMenu
{
    public string Name { get; set; }
    public string? Icon { get; set; }
    public List<string> Items { get; set; }
}
