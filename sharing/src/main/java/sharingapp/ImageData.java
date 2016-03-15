package sharingapp;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.*;

public class ImageData{
	private String albumName;
	private String imageUrl;
	private String blobKey;
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
	
	public String getBlobKey() {
		return blobKey;
	}
	public void setBlobKey(String blobKey) {
		this.blobKey = blobKey;
	}
	
	public ImageData(String albumName, String imageUrl, String blobKey) {
		super();
		this.albumName = albumName;
		this.imageUrl = imageUrl;
		this.blobKey = blobKey;
	}
	public ImageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}