require 'RMagick'
include CarrierWave::RMagick


def textembed(text, imgfile)
	imgpath = imgfile.imgdir.url
	img = ImageList.new(imgpath)
	txt = Draw.new
	img.annotate(txt, 0, 0, 0, 0, text) do |t|
		t.gravity = SouthGravity
		t.pointsize = 32
		t.stroke = 'transparent'
		t.font_weight = BoldWeight
		t.font_family = 'Helvetica'
		t.fill = 'white'
	end
	img.format = 'jpeg'
end