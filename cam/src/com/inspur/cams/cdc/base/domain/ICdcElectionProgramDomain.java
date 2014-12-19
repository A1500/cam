package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionProgram;

/**
 * 民主选举选举程序信息�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcElectionProgramDomain {

	/**
	 * ??��??民主选举选举程序信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????民主选举选举程序信息�?
	 * @param cdcElectionProgram
	 */
	@Trans
	public void insert(CdcElectionProgram cdcElectionProgram);
	
	/**
	 * �????民主选举选举程序信息�?
	 * @param cdcElectionProgram
	 */
	@Trans
	public void update(CdcElectionProgram cdcElectionProgram);
	
	/**
	 * ??????民主选举选举程序信息�?
	 * @param programId
	 */
	@Trans
	public void delete(String programId);

	public DataSet querySum(ParameterSet pset);

}