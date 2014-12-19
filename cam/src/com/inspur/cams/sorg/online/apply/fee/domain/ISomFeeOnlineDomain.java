package com.inspur.cams.sorg.online.apply.fee.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomFee;
/**
 * 章程信息会议domain接口
 * @author yanliangliang
 * @date 2011-9-21
 */
public interface ISomFeeOnlineDomain {
	
	/**
	 * 查询章程信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 查询章程信息
	 * @param pset
	 * @return
	 */
	public DataSet queryFee(ParameterSet pset);
	
	
	/**
	 * 更新章程信息
	 * @param somFee
	 */
	@Trans
	public void update(SomFee somFee);
	
	/**
	 * 增加章程核准业务
	 * @param somFee
	 */
	@Trans
	public void insertFeeApply(SomApply somApply, SomFee somFee);
	
	/**
	 * 更新章程业务
	 * @param somFee
	 */
	@Trans
	public void updateFeeApply(SomApply somApply, SomFee somFee);
	
	/**
	 * 外网申请调用插入
	 * @param somFee
	 */
	@Trans
	public void insertOnline(SomFee somFee);
}
