package com.codingdojo.chorestrackerpro.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.codingdojo.chorestrackerpro.models.Comment;
import com.codingdojo.chorestrackerpro.repositories.CommentRepository;

@Service
public class CommentService {
	
	@Autowired
	CommentRepository commentRepository;
	
	public Comment createComment(Comment comment) {
		return commentRepository.save(comment);
	}

	public void removComment(Long id) {
		List<Comment> optionalComment = commentRepository.findByIdAndIsNotRead(id);
		for(Comment comm : optionalComment) {
			Comment comment = comm;
			comment.setRead(true);
			commentRepository.save(comment);
			System.out.println("Comment has been Read");
		}
	}
	
	public List<Comment> allNotReadCommentsForUser(Long userId){
		return commentRepository.findByIdAndIsNotRead(userId);
	}
	
	public Page<Comment> allReadCommentsForUser(Long userId, int page, int size){
		Pageable pageable = PageRequest.of(page, size);		
		return commentRepository.findByIdAndIsRead(userId, pageable);
	}
	
	public void addToFavorie(Long id) {
		Optional<Comment> optionalComment = commentRepository.findById(id);
		if(optionalComment.isPresent()) {
			Comment comm = optionalComment.get();
			comm.setFavorie(!comm.isFavorie());
			commentRepository.save(comm);
		}
	}
}
