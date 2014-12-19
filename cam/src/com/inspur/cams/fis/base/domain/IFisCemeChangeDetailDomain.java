package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeChangeDetail;

/**
 * 公墓信息变更备案明细表domain
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeChangeDetailDomain {

	/**
	 * 查询 公墓信息变更备案明细表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 公墓信息变更备案明细表
	 * @param pset
	 * @return
	 */
	public FisCemeChangeDetail get(String detailId);

	/**
	 * 增加 公墓信息变更备案明细表
	 * @param fisCemeChangeDetail
	 */
	@Trans
	public void insert(FisCemeChangeDetail fisCemeChangeDetail);
	
	/**
	 * 修改 公墓信息变更备案明细表
	 * @param fisCemeChangeDetail
	 */
	@Trans
	public void update(FisCemeChangeDetail fisCemeChangeDetail);
	
	/**
	 * 删除 公墓信息变更备案明细表
	 * @param detailId
	 */
	@Trans
	public void delete(String detailId);
	@Trans
	public void deleteByChangeId(String changeId);
 
}