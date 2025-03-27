package com.vts.dms;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.Calendar;
import java.util.Locale;

public class FormatConverter 
{
	private SimpleDateFormat sqlDate =new SimpleDateFormat("yyyy-MM-dd");
	private SimpleDateFormat sqlDateAndTime=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	private SimpleDateFormat regularDate=new SimpleDateFormat("dd-MM-yyyy");
	private SimpleDateFormat regularDateTime=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
	private SimpleDateFormat dateMonthShortName=new SimpleDateFormat("dd-MMM-yyyy");
	private SimpleDateFormat dateMonthFullName=new SimpleDateFormat("dd-MMMM-yyyy");
	private int year=Calendar.getInstance().get(Calendar.YEAR);

	
	public int getYear() {
		return year;
	}
	
	public SimpleDateFormat getSqlDate() {
		return sqlDate;
	}
	public SimpleDateFormat getSqlDateAndTime() {
		return sqlDateAndTime;
	}
	public SimpleDateFormat getRegularDate() {
		return regularDate;
	}
	public SimpleDateFormat getDateMonthShortName() {
		return dateMonthShortName;
	}
	public SimpleDateFormat getDateMonthFullName() {
		return dateMonthFullName;
	}
	
	
	

	public int getYearFromRegularDate(String datestring) 
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
		LocalDate ldate=LocalDate.parse(datestring,formatter);
		return ldate.getYear();
	}
	public int getYearFromSqlDate(String datestring) 
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate ldate=LocalDate.parse(datestring,formatter);
		return ldate.getYear();
		
	}
	public int getYearFromSqlDateAndTime(String datetimestring)
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
		LocalDateTime ldatetime=LocalDateTime.parse(datetimestring,formatter);
		return ldatetime.getYear();
		
	}
	
	public int getMonthFromRegularDate(String datestring) 
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
		LocalDate ldate=LocalDate.parse(datestring,formatter);
		return ldate.getMonthValue();
	}
	public int getMonthFromSqlDate(String datestring) 
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate ldate=LocalDate.parse(datestring,formatter);
		return ldate.getMonthValue();
		
	}
	public int getMonthFromSqlDateAndTime(String datetimestring)
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
		LocalDateTime ldatetime=LocalDateTime.parse(datetimestring,formatter);
		return ldatetime.getMonthValue();
		
	}
	
	public String getMonthValFromRegularDate(String datestring) 
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
		LocalDate ldate=LocalDate.parse(datestring,formatter);
		return ldate.getMonth().getDisplayName(TextStyle.SHORT,Locale.ENGLISH);
	}
	public String getMonthValFromSqlDate(String datestring) 
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate ldate=LocalDate.parse(datestring,formatter);
		return ldate.getMonth().getDisplayName(TextStyle.SHORT,Locale.ENGLISH);
		
	}
	public String getMonthValFromSqlDateAndTime(String datetimestring)
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
		LocalDateTime ldatetime=LocalDateTime.parse(datetimestring,formatter);
		return ldatetime.getMonth().getDisplayName(TextStyle.SHORT,Locale.ENGLISH);
		
	}

	public SimpleDateFormat getRegularDateTime() {
		return regularDateTime;
	}
	
}
