package com.vts.dms.dak.dto;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.vts.dms.dak.model.DakCreate;
import com.vts.dms.dak.model.DakMain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DakAddDto {
	
	private DakMain dak;
	private DakCreate dakcreate;
	private String[] MarkedEmps;
	private MultipartFile MainDoc;
	private MultipartFile[] SubDoc;
	private Long DestinationId;
	private Long DestinationTypeId;
	
	
	   @JsonCreator
	public DakAddDto(@JsonProperty("dak")DakMain dak, @JsonProperty("MainDoc")MultipartFile MainDoc, @JsonProperty("dakcreate")DakCreate dakcreate,
			@JsonProperty("SubDoc") MultipartFile[] SubDoc,@JsonProperty("DestinationId")Long DestinationId,@JsonProperty("DestinationTypeId")Long DestinationTypeId
			) {
		super();
		this.dak = dak;
		this.MainDoc = MainDoc;
		this.dakcreate = dakcreate;
		this.SubDoc = SubDoc;
		this.DestinationId = DestinationId;
		this.DestinationTypeId = DestinationTypeId;
	}
	
}
