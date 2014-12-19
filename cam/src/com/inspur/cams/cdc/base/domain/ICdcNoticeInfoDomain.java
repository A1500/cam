package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcNoticeInfo;

public interface ICdcNoticeInfoDomain {
	
	public DataSet query(ParameterSet pset);
	
	public void insert(CdcNoticeInfo cdcNoticeInfo);
	
	public void delete(CdcNoticeInfo cdcNoticeInfo);
	
	public void delete(String noticeId) ;
	
	public void update(CdcNoticeInfo cdcNoticeInfo);
	
	
	/**
	 * 查询下属的申报
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryReport(ParameterSet pset);
	
	/**
	 * 查询上司的通知
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryNotice(ParameterSet pset);
	/**
	 * 查询自己的申报
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMyReport(ParameterSet pset);
	
	/**
	 * 查询自己的通知
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMyNotice(ParameterSet pset);
	
}
