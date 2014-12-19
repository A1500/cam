package com.inspur.cams.fis.base.cmd;

import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.base.domain.IFisResourceRuleDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceRuleCmd
 * @Description: TODO 殡葬业务资源级别规则定义Cmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceRuleCmd extends BaseAjaxCommand {

	IFisResourceRuleDomain service = ScaComponentFactory.getService(IFisResourceRuleDomain.class, "FisResourceRuleDomain/FisResourceRuleDomain");

	public void insert() {
	}

	public void update() {
	}

	/**
	 * 删除
	 */
	public void delete() {
	}

	/**
	 * 根据parentLevel删除
	 */
	public void deleteByParentLevel() {
	}
}