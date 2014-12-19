package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcElectionProgram;

/**
 * 民主选举选举程序信息�?Dao??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcElectionProgramDao extends BaseCURD<CdcElectionProgram> {

	DataSet querySum(ParameterSet pset);

}