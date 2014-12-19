package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomFee;

/**
 * 社会组织会费标准信息domain接口
 * @author yanliangliang
 * @date 2011-9-21
 */
public interface ISomFeeDomain {
	
	/**
	 * 查询会费标准信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 查询会费标准信息
	 * @param pset
	 * @return
	 */
	public DataSet queryFee(ParameterSet pset);

	/**
	 * 增加会费标准信息
	 * @param somFee
	 */
	@Trans
	public void insert(SomFee somFee);
	
	/**
	 * 更新会费标准信息
	 * @param somFee
	 */
	@Trans
	public void update(SomFee somFee);
	
	/**
	 * 外网插入
	 * @param somFee
	 */
	@Trans
	public void insertOnline(SomFee somFee);
	
	/**
	 * 备案时用的，插入会费信息时也插入apply
	 * @param somFee
	 */
	@Trans
	public void insertFeeAddApply(SomFee somFee);
	
	@Trans
	public void insertWithOutMeetingInfo(SomFee somFee);
	
	@Trans
	public void del(String taskCode);
	// 内网受理插入
	@Trans
	public void insertPre(SomFee somFee, SomApply somApply);
}
