package com.codingdojo.chorestrackerpro.models;

import org.springframework.web.multipart.MultipartFile;

public class ImgInfo {
	
	private MultipartFile filename;

    // Getter and setter
    public MultipartFile getFilename() {
        return filename;
    }

    public void setFilename(MultipartFile filename) {
        this.filename = filename;
    }

}
