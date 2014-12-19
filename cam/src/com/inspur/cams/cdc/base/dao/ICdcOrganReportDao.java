package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcOrganReport;

/**
 * 基础信息社区单位组织统计信息dao接口
 * @author shgtch
 * @date 2012-1-4
 */
public interface ICdcOrganReportDao extends BaseCURD<CdcOrganReport> {

	DataSet queryList(ParameterSet pset);

}