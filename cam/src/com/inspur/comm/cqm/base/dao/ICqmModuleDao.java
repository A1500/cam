package com.inspur.comm.cqm.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.data.CqmModule;

/**
 * 自定义统计报表模型表dao
 * @author shgtch
 * @date 2012-03-16
 */
public interface ICqmModuleDao extends BaseCURD<CqmModule> {

	DataSet queryModule(ParameterSet pset);

}