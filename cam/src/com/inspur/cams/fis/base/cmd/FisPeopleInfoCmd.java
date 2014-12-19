package com.inspur.cams.fis.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.comm.menuconfig.dao.PubMenuConfigDao;
import com.inspur.cams.comm.menuconfig.data.PubMenuConfig;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.fis.base.data.FisDutyInfo;
import com.inspur.cams.fis.base.data.FisPeopleInfo;
import com.inspur.cams.fis.base.domain.IFisPeopleInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisPeopleInfoCmd
 * @Description: TODO 殡葬业务工作人员信息表Cmd
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisPeopleInfoCmd extends BaseAjaxCommand {

	IFisPeopleInfoDomain fisPeopleInfoDomain = ScaComponentFactory.getService(IFisPeopleInfoDomain.class, "FisPeopleInfoDomain/FisPeopleInfoDomain");

	private PubMenuConfigDao dao = (PubMenuConfigDao) DaoFactory.getDao("com.inspur.cams.comm.menuconfig.dao.PubMenuConfigDao");

	public void insert() {
	}

	public void update() {
	}

	public void open() {
	}

	public void cencel() {
	}

	public void delete() {
	}
}
