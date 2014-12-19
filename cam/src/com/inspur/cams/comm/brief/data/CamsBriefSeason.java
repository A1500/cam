package com.inspur.cams.comm.brief.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 快报简报配置表databean
 * @author 
 * @date 2014-03-04
 */
@Table(tableName = "CAMS_BRIEF_SEASON", keyFields = "seasonId")
public class CamsBriefSeason extends StatefulDatabean {

	// 期数ID
	private String seasonId;

	// 地区编码
	private String organArea;

	// 地区名称
	private String organName;

	// 期数
	private String reportSeason;

	public String getSeasonId() {
		return seasonId;
	}

	public void setSeasonId(String seasonId) {
		this.seasonId = seasonId;
	}

	public String getOrganArea() {
		return organArea;
	}

	public void setOrganArea(String organArea) {
		this.organArea = organArea;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getReportSeason() {
		return reportSeason;
	}

	public void setReportSeason(String reportSeason) {
		this.reportSeason = reportSeason;
	}

}