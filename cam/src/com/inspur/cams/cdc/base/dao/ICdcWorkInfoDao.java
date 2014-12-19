package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcWorkInfo;

/**
 * 基层民主与社区建设工作交流dao
 * @author shgtch
 * @date 2012-3-1
 */
public interface ICdcWorkInfoDao extends BaseCURD<CdcWorkInfo> {

	DataSet queryList(ParameterSet pset);

}