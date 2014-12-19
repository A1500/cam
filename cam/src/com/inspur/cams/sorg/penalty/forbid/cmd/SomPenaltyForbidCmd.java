package com.inspur.cams.sorg.penalty.forbid.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.penalty.base.data.SomPenalty;
import com.inspur.cams.sorg.penalty.base.data.SomPenaltyApply;
import com.inspur.cams.sorg.penalty.forbid.domain.ISomPenaltyForbidDomain;
import com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail;

/**
 * 取缔非法社会组织cmd
 * 
 * @author:zhangjian
 * @since:2011-12-21
 */
public class SomPenaltyForbidCmd extends BaseAjaxCommand {
	private ISomPenaltyForbidDomain service = ScaComponentFactory.getService(
			ISomPenaltyForbidDomain.class,
			"somPenaltyForbidDomain/somPenaltyForbidDomain");

	/**
	 * 新增
	 */
	public void create() {
		service.create(getApply());
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
		Record[] somRestrictPeopleDetailRds = (Record[]) getParameter("somRestrictPeopleDetailRds");
		SomPenalty somPenalty = (SomPenalty) somPenaltyRd.toBean(SomPenalty.class);
		SomPenaltyApply somPenaltyApply = (SomPenaltyApply) somPenaltyApplyRd.toBean(SomPenaltyApply.class);
		somPenaltyApply.setSomPenalty(somPenalty);
		List<SomRestrictPeopleDetail> somRestrictPeopleDetailList = new ArrayList<SomRestrictPeopleDetail>();
		if (somRestrictPeopleDetailRds != null) {
			for (int i = 0; i < somRestrictPeopleDetailRds.length; i++) {
				SomRestrictPeopleDetail somRestrictPeopleDetail = (SomRestrictPeopleDetail) somRestrictPeopleDetailRds[i].toBean(SomRestrictPeopleDetail.class);
				somRestrictPeopleDetailList.add(somRestrictPeopleDetail);
			}
		}
		somPenaltyApply.setSomRestrictPeopleDetailList(somRestrictPeopleDetailList);
		return somPenaltyApply;
	}
}
