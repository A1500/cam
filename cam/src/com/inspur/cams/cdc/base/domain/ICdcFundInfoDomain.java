package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcFundInfo;

/**
 * 社区建设经费情况信息domain实现类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcFundInfoDomain {

	/**
	 * 查询社区建设经费情况信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社区建设经费情况信息
	 * @param cdcFundInfo
	 */
	@Trans
	public void insert(CdcFundInfo cdcFundInfo);
	
	/**
	 * 修改社区建设经费情况信息
	 * @param cdcFundInfo
	 */
	@Trans
	public void update(CdcFundInfo cdcFundInfo);
	
	/**
	 * 删除社区建设经费情况信息
	 * @param fundId
	 */
	@Trans
	public void delete(String fundId);
	
	/**
	 * 汇总社区建设经费情况信息
	 * @param cdcFundInfo
	 */
	@Trans
	public void sum(CdcFundInfo cdcFundInfo);

}