package com.codingdojo.chorestrackerpro.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
		List<Comment> optionalComment = commentRepository.findByIdAndIsRead(id);
		for(Comment comm : optionalComment) {
			Comment comment = comm;
			comment.setRead(true);
			commentRepository.save(comment);
			System.out.println("Comment has been Read");
		}
	}
	
	public List<Comment> allNotReadCommentsForUser(Long userId){
		return commentRepository.findByIdAndIsRead(userId);
	}
}
