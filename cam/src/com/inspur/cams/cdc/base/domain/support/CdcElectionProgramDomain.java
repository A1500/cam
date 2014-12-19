package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcElectionProgramDao;
import com.inspur.cams.cdc.base.data.CdcElectionProgram;
import com.inspur.cams.cdc.base.domain.ICdcElectionProgramDomain;

/**
 * 民主选举选举程序信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcElectionProgramDomain implements ICdcElectionProgramDomain {

	@Reference
	private ICdcElectionProgramDao cdcElectionProgramDao;

	/**
	 * ??��??民主选举选举程序信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcElectionProgramDao.query(pset);
	}

	/**
	 * �????民主选举选举程序信息�?
	 * @param cdcElectionProgram
	 */
	public void insert(CdcElectionProgram cdcElectionProgram) {
		cdcElectionProgramDao.insert(cdcElectionProgram);
	}
	
	/**
	 * �????民主选举选举程序信息�?
	 * @param cdcElectionProgram
	 */
	public void update(CdcElectionProgram cdcElectionProgram) {
		cdcElectionProgramDao.update(cdcElectionProgram);
	}
	
	/**
	 * ??????民主选举选举程序信息�?
	 * @param programId
	 */
	public void delete(String programId) {
		cdcElectionProgramDao.delete(programId);
	}

	public DataSet querySum(ParameterSet pset) {
		return cdcElectionProgramDao.querySum(pset);
	}

}