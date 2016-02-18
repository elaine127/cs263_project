package sharingapp;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.*;

@XmlRootElement
//JAX-RS supports an automatic mapping from JAXB annotated class to XML and JSON
public class AlbumData 
{
private String albumName;
private String notes;
private String imageUrl;
public String getAlbumName() {
	return albumName;
}
public void setAlbumName(String albumName) {
	this.albumName = albumName;
}
public String getNotes() {
	return notes;
}
public void setNotes(String notes) {
	this.notes = notes;
}
public String getImageUrl() {
	return imageUrl;
}
public void setImageUrl(String imageUrl) {
	this.imageUrl = imageUrl;
}
public AlbumData(String albumName, String notes, String imageUrl) {
	super();
	this.albumName = albumName;
	this.notes = notes;
	this.imageUrl = imageUrl;
}
public AlbumData() {
	super();
}


//add constructors (default () and (String,String,Date))



} 
