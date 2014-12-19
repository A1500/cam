package com.inspur.cams.sorg.apply.group.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.apply.group.domain.IGroupCancelDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomOrgan;

public class GroupCancelCmd extends BaseAjaxCommand {
	// 获取SCA组件
	private IGroupCancelDomain service = ScaComponentFactory.getService(
			IGroupCancelDomain.class, "groupCancelDomain/groupCancelDomain");

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
		Record[] somLiqpeopleRds = (Record[]) getParameter("somLiqpeopleRds");
		Record somApplyRd = (Record) getParameter("somApplyRd");
		SomOrgan somOrgan = (SomOrgan) somOrganRd.toBean(SomOrgan.class);
		SomApply somApply = (SomApply) somApplyRd.toBean(SomApply.class);

		// 获取前台社会组织清算人员信息列表
		if (somLiqpeopleRds != null) {
			for (int i = 0; i < somLiqpeopleRds.length; i++) {
				SomLiqpeople somLiqpeople = (SomLiqpeople) somLiqpeopleRds[i]
						.toBean(SomLiqpeople.class);
				somLiqpeopleList.add(somLiqpeople);
			}
			somOrgan.setSomLiqpeopleList(somLiqpeopleList);
		}
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

	/**
	 * 获取最后环节processId
	 */
	public String getProcessId(String id) {
		return service.queryProcessId(id);
	}
}
