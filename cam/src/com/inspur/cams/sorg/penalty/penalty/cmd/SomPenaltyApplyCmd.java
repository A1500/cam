package com.inspur.cams.sorg.penalty.penalty.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.penalty.base.data.SomPenalty;
import com.inspur.cams.sorg.penalty.base.data.SomPenaltyApply;
import com.inspur.cams.sorg.penalty.penalty.domain.ISomPenaltyApplyDomain;

/**
 * 行政处罚cmd
 * 
 * @author:zhangjian
 * @since:2011-12-21
 */
public class SomPenaltyApplyCmd extends BaseAjaxCommand {
	private ISomPenaltyApplyDomain service = ScaComponentFactory
			.getService(ISomPenaltyApplyDomain.class,
					"somPenaltyApplyDomain/somPenaltyApplyDomain");

	/**
	 * 新增
	 */
	public void create() {
		service.create(getApply());
	}
	
	/**
	 * 年检不合格的保存到行政执法的数据保存时调用此方法
	 */
	public void createAndUpdateCheck() {
		Map map = new HashMap();
		String checkTaskCode = (String) getParameter("checkTaskCode");
		map.put("checkTaskCode", checkTaskCode);
		service.createAndUpdateCheck(getApply(), map);
	}
	
	/**
	 * 年检不合格提交
	 */
	public void createSubmitAndUpdateCheck() {
		Map map = new HashMap();
		String checkTaskCode = (String) getParameter("checkTaskCode");
		map.put("checkTaskCode", checkTaskCode);
		service.createSubmitAndUpdateCheck(getApply(), map);
	}

	/**
	 * 新增并提交
	 */
	public void createSubmit() {
		service.createSubmit(getApply());
	}

	/**
	 * 保存
	 */
	public void save() {
		service.save(getApply());
	}

	/**
	 * 提交
	 */
	public void submit() {
		service.submit(getApply());
	}

	/**
	 * 获取信息
	 * 
	 * @return SomPenaltyApply
	 */
	private SomPenaltyApply getApply() {
		Record somPenaltyRd = (Record) getParameter("somPenaltyRd");
		Record somPenaltyApplyRd = (Record) getParameter("somPenaltyApplyRd");
		SomPenalty somPenalty = (SomPenalty) somPenaltyRd
				.toBean(SomPenalty.class);
		SomPenaltyApply somPenaltyApply = (SomPenaltyApply) somPenaltyApplyRd
				.toBean(SomPenaltyApply.class);
		somPenaltyApply.setSomPenalty(somPenalty);
		return somPenaltyApply;
	}
}
