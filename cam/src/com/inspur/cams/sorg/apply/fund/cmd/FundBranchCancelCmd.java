package com.inspur.cams.sorg.apply.fund.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.apply.fund.domain.IFundBranchCancelDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOrgan;

public class FundBranchCancelCmd extends BaseAjaxCommand {
	// 获取SCA组件
	private IFundBranchCancelDomain service = ScaComponentFactory.getService(
			IFundBranchCancelDomain.class,
			"fundBranchCancelDomain/fundBranchCancelDomain");

	/**
	 * 新增注销
	 */
	public void create() {
		SomApply somApply = getSomApply();
		service.create(somApply);
	}

	/**
	 * 新增注销并提交流程
	 */
	public void createAndSend() {
		SomApply somApply = getSomApply();
		service.createAndSend(somApply);
	}

	/**
	 * 修改注销
	 */
	public void update() {
		SomApply somApply = getSomApply();
		service.update(somApply);
	}

	/**
	 * 修改注销并提交流程
	 */
	public void updateAndSend() {
		SomApply somApply = getSomApply();
		service.updateAndSend(somApply);
	}

	private SomApply getSomApply() {
		// 获取前台社会组织信息
		Record somOrganRd = (Record) getParameter("somOrganRd");
		SomOrgan somOrgan = (SomOrgan) somOrganRd.toBean(SomOrgan.class);

		// 获取前台业务意见信息
		Record somApplyRd = (Record) getParameter("somApplyRd");
		SomApply somApply = (SomApply) somApplyRd.toBean(SomApply.class);

		// 封装数据
		somApply.setSomOrgan(somOrgan);
		return somApply;
	}

	/**
	 * 查询社会组织状态
	 */
	/**
	 * 查询社会组织状态
	 */
	public void querySorgStatus() {
		String sorgId = (String) getParameter("sorgId");
		String ifBranch = (String) getParameter("ifBranch");
		SomOrgan somOrgan = service.querySorgStatus(sorgId, ifBranch);
		setReturn("sorgStatus", somOrgan.getSorgStatus());
		setReturn("legalPeople", somOrgan.getLegalPeople());
		setReturn("organCode", somOrgan.getOrganCode());
	}
}
