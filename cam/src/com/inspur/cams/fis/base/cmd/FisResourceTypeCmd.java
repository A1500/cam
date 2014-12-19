package com.inspur.cams.fis.base.cmd;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.base.domain.IFisResourceTypeDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceTypeCmd
 * @Description: TODO 殡葬业务资源分类表Cmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceTypeCmd extends BaseAjaxCommand {

	IFisResourceTypeDomain service = ScaComponentFactory.getService(IFisResourceTypeDomain.class, "FisResourceTypeDomain/FisResourceTypeDomain");

	public void insert() {
	}

	public void update() {
	}

	public void delete() {
	}

	public void save() {
	}
}