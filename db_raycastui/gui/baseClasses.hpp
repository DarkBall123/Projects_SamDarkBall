class DB_RUI_RscText
{
    access = 0;
    type = 0;
    idc = -1;
    style = 0;
    linespacing = 1;
    x = 0;
    y = 0;
    h = 0.037;
    w = 0.3;
    text = "";
    shadow = 1;
    font = "PuristaMedium";
    SizeEx = 0.035;
    colorBackground[] = {0, 0, 0, 0};
    colorText[] = {1, 1, 1, 1};
};

class DB_RUI_RscPicture : DB_RUI_RscText
{
    style = 48;
    font = "TahomaB";
    SizeEx = 0;
    lineSpacing = 0;
};

class DB_RUI_RscStructuredText
{
    access = 0;
    type = 13;
    idc = -1;
    style = 0;
    x = 0;
    y = 0;
    h = 0.035;
    w = 0.1;
    text = "";
    size = 0.035;
    shadow = 1;
    colorBackground[] = {0, 0, 0, 0};
    class Attributes
    {
        font = "PuristaMedium";
        color = "#F2E7BF";
        align = "left";
        valign = "top";
        shadow = 1;
    };
};

class DB_RUI_RscControlsGroupNoScrollbars
{
    access = 0;
    type = 15;
    idc = -1;
    style = 16;
    x = 0;
    y = 0;
    w = 1;
    h = 1;
    shadow = 0;
    class VScrollbar
    {
        width = 0;
        autoScrollEnabled = 0;
    };
    class HScrollbar
    {
        height = 0;
    };
    class controls
    {
    };
};
