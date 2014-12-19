package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeCheckHistory;

/**
 * 公墓年检整改历史记录表domain
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeCheckHistoryDomain {

	/**
	 * 查询 公墓年检整改历史记录表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 查询 公墓年检整改历史记录表通过时间排序
	 * @param pset
	 * @return
	 */
	public DataSet queryOrder(ParameterSet pset);
	/**
	 * 查询 通过创建时间排序
	 * @param pset
	 * @return
	 */
	public DataSet queryByCreateTime(ParameterSet pset);

	/**
	 * 获取 公墓年检整改历史记录表
	 * @param pset
	 * @return
	 */
	public FisCemeCheckHistory get(String hisId);

	/**
	 * 增加 公墓年检整改历史记录表
	 * @param fisCemeCheckHistory
	 */
	@Trans
	public void insert(FisCemeCheckHistory fisCemeCheckHistory);
	
	/**
	 * 修改 公墓年检整改历史记录表
	 * @param fisCemeCheckHistory
	 */
	@Trans
	public void update(FisCemeCheckHistory fisCemeCheckHistory);
	
	/**
	 * 删除 公墓年检整改历史记录表
	 * @param hisId
	 */
	@Trans
	public void delete(String hisId);
	

	/**
	 * 修改 公墓新建 流程上行意见历史记录
	 * @param fisCemeCheckHistory
	 */
	@Trans
	public void updateUp(String hisId,String result,String opinion);
	
	

}