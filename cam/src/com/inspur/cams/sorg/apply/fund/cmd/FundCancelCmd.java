package com.inspur.cams.sorg.apply.fund.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.apply.fund.domain.IFundCancelDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomOrgan;

public class FundCancelCmd extends BaseAjaxCommand {
	// 获取SCA组件
	private IFundCancelDomain service = ScaComponentFactory.getService(
			IFundCancelDomain.class, "fundCancelDomain/fundCancelDomain");

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

	/**
	 * 获取社会组织业务
	 * 
	 * @return SomApply
	 */
	private SomApply getSomApply() {
		List<SomLiqpeople> somLiqpeopleList = new ArrayList<SomLiqpeople>();
		// 获取前台社会组织信息
		Record somOrganRd = (Record) getParameter("somOrganRd");
		SomOrgan somOrgan = (SomOrgan) somOrganRd.toBean(SomOrgan.class);
		String sorgId = somOrgan.getSorgId();

		// 获取前台社会组织清算人员信息列表
		Record[] somLiqpeopleRds = (Record[]) getParameter("somLiqpeopleRds");
		if (somLiqpeopleRds != null && somLiqpeopleRds.length > 0) {
			for (int i = 0; i < somLiqpeopleRds.length; i++) {
				SomLiqpeople somLiqpeople = (SomLiqpeople) somLiqpeopleRds[i]
						.toBean(SomLiqpeople.class);
				if (somLiqpeople.getState() == Record.STATE_NEW) {
					somLiqpeople.setId(IdHelp.getUUID30());
					somLiqpeople.setSorgId(sorgId);
				}
				somLiqpeopleList.add(somLiqpeople);
			}
			somOrgan.setSomLiqpeopleList(somLiqpeopleList);
		}

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
	public void querySorgStatus() {
		String sorgId = (String) getParameter("sorgId");
		setReturn("sorgStatus", service.querySorgStatus(sorgId));
	}

	/**
	 * 根据sorgId，删除社会组织清算组织人员
	 */
	public void delLiqpeopleBySorgId() {
		String sorgId = (String) getParameter("sorgId");
		service.delLiqpeopleBySorgId(sorgId);
	}
}
