package com.inspur.cams.sorg.penalty.penalty.domain;

import java.util.Map;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.penalty.base.data.SomPenaltyApply;

/**
 * 行政处罚domain接口
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
public interface ISomPenaltyApplyDomain {
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
	
	/**
	 * 年检不合格的保存到行政执法的数据保存时调用此方法
	 */
	@Trans
	public void createAndUpdateCheck(SomPenaltyApply somPenaltyApply,Map map);
	
	/**
	 * 年检不合格的提交到行政执法的数据提交时调用此方法
	 * @param somPenaltyApply
	 * @param map
	 */
	@Trans
	public void createSubmitAndUpdateCheck(SomPenaltyApply somPenaltyApply,Map map);
}
