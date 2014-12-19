package com.inspur.cams.comm.brief.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.brief.dao.ICamsReportWorkDao;
import com.inspur.cams.comm.brief.data.CamsReportWork;

/**
 * 填报期数配置表dao
 * @author 
 * @date 2014-04-23
 */
public class CamsReportWorkDao extends EntityDao<CamsReportWork> implements ICamsReportWorkDao {
	
	@Override
	public Class<CamsReportWork> getEntityClass() {
		return CamsReportWork.class;
	}

}