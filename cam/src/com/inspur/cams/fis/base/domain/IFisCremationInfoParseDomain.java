package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCremationInfoParse;

/**
 * �ϱ����������ѯdomain
 * @author 
 * @date 2013-11-07
 */
public interface IFisCremationInfoParseDomain {

	/**
	 * 查询 �ϱ����������ѯ
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);


	/**
	 * 增加 �ϱ����������ѯ
	 * @param fisCremationInfoParse
	 */
	@Trans
	public void insert(FisCremationInfoParse fisCremationInfoParse);
	
	/**
	 * 修改 �ϱ����������ѯ
	 * @param fisCremationInfoParse
	 */
	@Trans
	public void update(FisCremationInfoParse fisCremationInfoParse);
	
	/**
	 * 删除 �ϱ����������ѯ
	 * @param 
	 */
	@Trans
	public void delete(String unitId);
	
	
	@Trans
	public DataSet queryDs(ParameterSet pset);

}