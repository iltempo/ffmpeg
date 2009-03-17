require File.dirname(__FILE__) + '/spec_helper'

describe "FFMpeg" do
  before(:each) do
    @from_file, @to_file = "~/Desktop/test.avi", "~/Desktop/test2.avi"
    FFMpegCommand.clear
  end
  
  it "should generate a valid command" do
    convert @from_file, :to => @to_file
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file}")
  end
  
  it "should generate a valid command when fed an empty block" do
    convert(@from_file, :to => @to_file) {}
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file}")
  end
end

describe "FFMpeg Main Options" do
  before(:each) do
    @from_file, @to_file = "~/Desktop/test.avi", "~/Desktop/test2.avi"
    FFMpegCommand.clear
  end
  
  it "should overwrite existing files" do
    convert @from_file, :to => @to_file do
      overwrite_existing_file
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -y -i #{@from_file} #{@to_file}")
  end
  
  it "should set a duration" do
    convert @from_file, :to => @to_file do
      duration "00:03:01"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -t 00:03:01")
  end
  
  it "should set a file size limit" do
    convert @from_file, :to => @to_file do
      file_size_limit 104_857_600
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -fs 104857600")
  end
  
  it "should seek to the specified time position" do
    convert @from_file, :to => @to_file do
      seek "00:03:01"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -ss 00:03:01")
  end
  
  it "should the input time offset" do
    convert @from_file, :to => @to_file do
      offset "00:03:01"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -itsoffset 00:03:01")
  end
  
  it "should the title" do
    convert @from_file, :to => @to_file do
      title "Some Title"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -title 'Some Title'")
  end
  
  it "should the author" do
    convert @from_file, :to => @to_file do
      author "PMH"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -author 'PMH'")
  end
  
  it "should the copyright" do
    convert @from_file, :to => @to_file do
      copyright "(c) Patrik Hedman 2009"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -copyright '(c) Patrik Hedman 2009'")
  end
  
  it "should the comment" do
    convert @from_file, :to => @to_file do
      comment "Some Comment"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -comment 'Some Comment'")
  end
  
  it "should the album" do
    convert @from_file, :to => @to_file do
      album "An awesome album"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -album 'An awesome album'")
  end
  
  it "should the track" do
    convert @from_file, :to => @to_file do
      track 1
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -track 1")
  end
  
  it "should the year" do
    convert @from_file, :to => @to_file do
      year 1985
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -year 1985")
  end
  
  it "should the target" do
    convert @from_file, :to => @to_file do
      target "vcd"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -target vcd")
  end
  
  it "should the number of frames to record" do
    convert @from_file, :to => @to_file do
      frames_to_record 50
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -dframes 50")
  end
  
  it "should set the subtitle codec" do
    convert @from_file, :to => @to_file do
      subtitle_codec 'copy'
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -scodec copy")
  end
end

describe "FFMpeg Video Options" do
  before(:each) do
    @from_file, @to_file = "~/Desktop/test.avi", "~/Desktop/test2.avi"
    FFMpegCommand.clear
  end
  
  it "should set the resolution" do
    convert @from_file, :to => @to_file do
      resolution "vga"
    end
    
    FFMpegCommand.command("ffmpeg").should eql("ffmpeg -i #{@from_file} #{@to_file} -s vga")
  end
end