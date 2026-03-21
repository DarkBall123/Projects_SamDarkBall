#ifndef STING_CONFIG_MACROS_HPP
#define STING_CONFIG_MACROS_HPP

#define QSTR(x) #x
#define QSTING_CFG_PATH(P) QSTR(\sting\P)
#define QSTING_CFG_DATA(P) QSTR(\sting\ui\P)
#define QSTING_CFG_PIC(P) QSTR(\sting\pictures\P)
#define QSTING_CFG_FONT(P) QSTR(\sting\font\P)
#define QSTING_CFG_SOUND(P) QSTR(\sting\sounds\P)

#define STING_MAG_COMMON(DESC,NAME,MODEL,SUFFIX) \
	author="DarkBall"; \
	descriptionShort=DESC; \
	displayName=NAME; \
	model=MODEL; \
	icon=QSTING_CFG_DATA(drononmap.paa); \
	picture=QSTING_CFG_DATA(drononmap.paa); \
	mass=150; \
	count=1; \
	ammo=""; \
	DB_stingVehicleSuffix=SUFFIX

#endif
