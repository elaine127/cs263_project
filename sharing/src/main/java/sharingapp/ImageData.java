package sharingapp;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.*;

public class ImageData{
	private String albumName;
	private String imageUrl;
	public String getAlbumName() {
		return albumName;
	}
	public void setAlbumName(String albumName) {
		this.albumName = albumName;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public ImageData(String albumName, String imageUrl) {
		super();
		this.albumName = albumName;
		this.imageUrl = imageUrl;
	}
	public ImageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}