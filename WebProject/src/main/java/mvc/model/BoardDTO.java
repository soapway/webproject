package mvc.model;

public class BoardDTO {
	private int num;
	private String user_id;
	private String title;
	private String artist;
	private String album;
	private String album_art;
	private String genre;
	private String lyric;
	
	
	private String id;
	private String password;
	private String name;
	private String user_img;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUser_img() {
		return user_img;
	}

	public void setUser_img(String userimg) {
		this.user_img = userimg;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String userid) {
		this.user_id = userid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}

	public String getAlbum() {
		return album;
	}

	public void setAlbum(String album) {
		this.album = album;
	}

	public String getAlbum_art() {
		return album_art;
	}

	public void setAlbum_art(String albumart) {
		this.album_art = albumart;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getLyric() {
		return lyric;
	}

	public void setLyric(String lyric) {
		this.lyric = lyric;
	}

}
