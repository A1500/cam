package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamApplyOptionsHis;

/**
 * @title:申请审批历史意见Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamApplyOptionsHisDomain {
	/**
	 * 查询申请审批历史意见
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加申请审批历史意见
	 * @param samApplyOptionsHis
	 */
	@Trans
	public void insert(SamApplyOptionsHis samApplyOptionsHis);
	
	/**
	 * 更新申请审批历史意见
	 * @param samApplyOptionsHis
	 */
	@Trans
	public void update(SamApplyOptionsHis samApplyOptionsHis);
}
