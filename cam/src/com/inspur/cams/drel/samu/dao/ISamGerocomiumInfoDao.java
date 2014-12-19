package com.inspur.cams.drel.samu.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.samu.data.SamGerocomiumInfo;

/**
 * 敬老院基础信息dao
 * @author 
 * @date 2012-09-26
 */
public interface ISamGerocomiumInfoDao extends BaseCURD<SamGerocomiumInfo> {
	public void deleteAll(String gerocomiumId);
	public void updateOldYear(String recordId);
	public DataSet queryGero(ParameterSet pset);
	public DataSet reportGeroInfo(ParameterSet pset);
	public DataSet count1(ParameterSet pset);
	public DataSet count2(ParameterSet pset);
}