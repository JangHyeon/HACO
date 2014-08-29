package kr.co.haco.VO;

public class UploadFile {
	private int file_id;
	private String file_type;
	private String board_name;
	private String orign_file;
	private String save_file;
	private long filesize;
	
	
	
	public int getFile_id() {
		return file_id;
	}
	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public String getOrign_file() {
		return orign_file;
	}
	public void setOrign_file(String orign_file) {
		this.orign_file = orign_file;
	}
	public String getSave_file() {
		return save_file;
	}
	public void setSave_file(String save_file) {
		this.save_file = save_file;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	
	
}
