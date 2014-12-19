package com.inspur.cams.sorg.penalty.forbid.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.penalty.base.data.SomPenaltyApply;

/**
 * 取缔非法社会组织domain接口
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
public interface ISomPenaltyForbidDomain {
	/**
	 * 新增
	 * 
	 * @param somPenaltyApply
	 */
	@Trans
	public void create(SomPenaltyApply somPenaltyApply);

	/**
	 * 新增并提交
	 * 
	 * @param somPenaltyApply
	 */
	@Trans
	public void createSubmit(SomPenaltyApply somPenaltyApply);

	/**
	 * 保存
	 * 
	 * @param somPenaltyApply
	 */
	@Trans
	public void save(SomPenaltyApply somPenaltyApply);

	/**
	 * 提交
	 * 
	 * @param somPenaltyApply
	 */
	@Trans
	public void submit(SomPenaltyApply somPenaltyApply);
}
