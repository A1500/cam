package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptRegularInformationCue;
import com.inspur.cams.bpt.base.domain.IBptRegularInformationCueDomain;

/**
 * @title:BptRegularInformationCueCommand
 * @description:定期信息提示确认
 * @author:
 * @since:2011-06-03
 * @version:1.0
*/
public class BptRegularInformationCueCommand extends BaseAjaxCommand{
	IBptRegularInformationCueDomain service = ScaComponentFactory.getService(IBptRegularInformationCueDomain.class,
	"bptRegularInformationCueDomain/bptRegularInformationCueDomain");

	/**
	 * 定期信息提示确认
	 */
	@Trans
	public void update(){
		ParameterSet pset = getParameterSet();
		BptRegularInformationCue dataBean = (BptRegularInformationCue)service.query(pset).getRecord(0).toBean(BptRegularInformationCue.class);
		service.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.batchDelete(delIds);
	}
}
