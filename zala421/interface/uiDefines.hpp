class ctrlControlsGroupNoScrollBars;
class ctrlStaticBackGround;
class ctrlStructuredText;
class ctrlStaticPicture;

#define GRID_W( num ) ( num * ( pixelGridNoUIScale * pixelW * 2 ))
#define GRID_H( num ) ( num * ( pixelGridNoUIScale * pixelH * 2 ))

#define INFOBOX_W ( GRID_W(2.5) )
#define INFOBOX_H ( GRID_H(1.5) )

#define INFOBOX_PADDING_W ( GRID_W(0.1) )
#define INFOBOX_PADDING_H ( GRID_H(0.1) )
#define INFOBOX_TEXT_SIZE ( GRID_H(1.0) )

#define ANGLE_GROUP_X ( safeZoneX + GRID_W(5) )
#define ANGLE_GROUP_Y ( safeZoneY + GRID_H(2) )

#define ANGLE_SCALE_W ( GRID_W(1.5) )
#define ANGLE_SCALE_H ( GRID_H(15) )

#define ZALA_BASEBOX_H ( GRID_H(1.4) ) 