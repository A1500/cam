package com.inspur.cams.fis.base.cmd;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.base.domain.IFisResourceLevelDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceLevelCmd
 * @Description: TODO 殡葬业务资源级别定义Cmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceLevelCmd extends BaseAjaxCommand {

	IFisResourceLevelDomain service = ScaComponentFactory.getService(IFisResourceLevelDomain.class, "FisResourceLevelDomain/FisResourceLevelDomain");

	public void insert() {
	}

	public void update() {
	}

	public void delete() {
	}

	public void save() {
	}
}