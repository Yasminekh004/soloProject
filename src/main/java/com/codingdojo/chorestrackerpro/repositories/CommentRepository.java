package com.codingdojo.chorestrackerpro.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.chorestrackerpro.models.Comment;


@Repository
public interface CommentRepository  extends CrudRepository<Comment, Long> {
	
	@Query(value = "SELECT * FROM comments WHERE is_read = false AND reader_id = :userId", nativeQuery = true)
	List<Comment> findByIdAndIsRead(Long userId);

}
