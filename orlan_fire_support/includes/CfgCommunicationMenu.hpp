class CfgCommunicationMenu
{
    class Orlan_FireSupport
    {
        text = "Fire Support";                                   // Text displayed in the menu and in a notification
        submenu = "";                                                 // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "[] spawn orlan_fs_fnc_callSupport";                             // Code executed upon activation
        icon = "";
		cursor = "";    // Custom cursor displayed when the item is selected
        enable = "1";					// Simple expression condition for enabling the item                                                // Simple expression condition for enabling the item
        removeAfterExpressionCall = 0;
    };
};