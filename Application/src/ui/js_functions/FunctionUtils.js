function clamp(x, min, max)
{
	return Math.max(min, Math.min(x, max));
}

function hsba(hue, saturation, brightness, alpha)
{
	var lightness = (2 - saturation)*brightness;
	var satHSL = saturation*brightness/((lightness <= 1) ? lightness : 2 - lightness);
	lightness /= 2;
	return Qt.hsla(hue, satHSL, lightness, alpha);
}

function clamp(val, min, max)
{
	return Math.max(min, Math.min(max, val)) ;
}

function mix(x, y , a)
{
	return x * (1 - a) + y * a ;
}

function hsvaToRgba(hsva)
{
	var luminance = hsva.z * hsva.y ;
	var intermediate_coefficient = luminance * (1 - Math.abs( (hsva.x * 6) % 2 - 1 )) ;
	var saturation = hsva.z - luminance ;
	var red = Math.max(0, luminance + saturation);
	var green = Math.max(0, intermediate_coefficient + saturation);
	var blue = Math.max(0, saturation);

	if (hsva.x < 1/6 ) {
		return Qt.vector4d(red, green, blue, hsva.w) ;
	} else if (hsva.x < 1/3 ) {
		return Qt.vector4d(green, red, blue, hsva.w) ;
	} else if (hsva.x < 0.5 ) {
		return Qt.vector4d(blue, red, green, hsva.w) ;
	} else if (hsva.x < 2/3 ) {
		return Qt.vector4d(blue, green, red, hsva.w) ;
	} else if (hsva.x < 5/6 ) {
		return Qt.vector4d(green, blue, red, hsva.w) ;
	} else {
		return Qt.vector4d(red, blue, green, hsva.w) ;
	}
}

function rgbaToHsva(rgba)
{
	var red = rgba.x;
	var green = rgba.y;
	var blue = rgba.z;
	var max = Math.max(red, green, blue)
	var min = Math.min(red, green, blue);
	var hue, saturation, value = max;

	var intermediate_coefficient = max - min;
	saturation = max === 0 ? 0 : intermediate_coefficient / max;

	if(max == min){
		hue = 0;
	} else{
		switch(max){
		case red:
			hue = (green - blue) / intermediate_coefficient + (green < blue ? 6 : 0);
			break;
		case green:
			hue = (blue - red) / intermediate_coefficient + 2;
			break;
		case blue:
			hue = (red - green) / intermediate_coefficient + 4;
			break;
		}
		hue /= 6;
	}

	return Qt.vector4d(hue, saturation, value, rgba.w);
}

function getChannelStr(clr, channelIdx) {
	return parseInt(clr.toString().substr(channelIdx*2 + 1, 2), 16);
}

function intToHexa(val , nb)
{
	var hexaTmp = val.toString(16) ;
	var hexa = "";
	var size = hexaTmp.length
	if (size < nb ) {
		for(var i = 0 ; i < nb - size ; ++i)
		{
			hexa += "0"
		}
	}
	return hexa + hexaTmp
}

function hexaFromRGBA(red, green, blue, alpha)
{
	const v_red = intToHexa(Math.round(red * 255), 2);
	const v_green = intToHexa(Math.round(green * 255), 2);
	const v_blue = intToHexa(Math.round(blue * 255), 2);
	return v_red + v_green + v_blue;
}
