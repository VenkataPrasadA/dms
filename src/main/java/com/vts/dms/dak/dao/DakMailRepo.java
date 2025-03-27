package com.vts.dms.dak.dao;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.vts.dms.dak.model.DakMail;



@Repository
public interface DakMailRepo
  extends CrudRepository<DakMail, Long> {


	List<DakMail> findByRecievedDate(Date recievedDate);
	@Query(value = "SELECT u FROM DakMail u WHERE Date(u.recievedDate)=:recievedDate AND u.mailType=:mailType")
	List<DakMail> findByRecievedDateAndType(@Param("recievedDate") Date recievedDate,@Param("mailType") String mailType);
	
	DakMail findByDakMailId(Long dakMailId);
}
