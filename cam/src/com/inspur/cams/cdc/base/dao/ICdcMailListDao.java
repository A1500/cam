package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcMailList;

/**
 * 基层民主与社区建设通讯录dao
 * @author shgtch
 * @date 2012-3-1
 */
public interface ICdcMailListDao extends BaseCURD<CdcMailList> {

	DataSet queryList(ParameterSet pset);

}