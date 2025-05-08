package com.codingdojo.chorestrackerpro.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.chorestrackerpro.models.Comment;


@Repository
public interface CommentRepository  extends CrudRepository<Comment, Long> {
	
	@Query(value = "SELECT * FROM comments WHERE is_read = false AND reader_id = :userId", nativeQuery = true)
	List<Comment> findByIdAndIsNotRead(Long userId);

	@Query(value = "SELECT * FROM comments WHERE is_read = true AND reader_id = :userId", nativeQuery = true)
	Page<Comment> findByIdAndIsRead(Long userId, Pageable pageable);
}
