package com.inspur.cams.comm.brief.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.brief.data.CamsBriefConfig;


/**
 * 快报简报配置表dao
 * @author 
 * @date 2014-03-04
 */
public interface ICamsBriefConfigDao extends BaseCURD<CamsBriefConfig> {

	public DataSet queryCount(ParameterSet pset);
}