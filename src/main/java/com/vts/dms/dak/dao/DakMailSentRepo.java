package com.vts.dms.dak.dao;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.vts.dms.dak.model.DakMailSent;



@Repository
public interface DakMailSentRepo
  extends CrudRepository<DakMailSent, Long> {


	List<DakMailSent> findBySentDate(Date sentDate);
	@Query(value = "SELECT u FROM DakMailSent u WHERE u.sentDate=:sentDate AND u.mailType=:mailType")
	List<DakMailSent> findByRecievedDateAndType(@Param("sentDate") Date sentDate,@Param("mailType") String mailType);
}
