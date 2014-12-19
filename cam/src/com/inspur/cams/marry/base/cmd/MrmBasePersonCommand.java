package com.inspur.cams.marry.base.cmd;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.CamsProperties;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.marry.base.dao.jdbc.MrmBasePersonDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;
import com.inspur.cams.marry.base.data.MrmRegisOrganInfo;
import com.inspur.cams.marry.base.domain.IMrmBasePersonDomain;
import com.inspur.cams.marry.base.domain.IMrmRegisOrganInfoDomain;
/**
 * 婚登用户维护
 * @author shgtch
 * @date 2011-12-5
 */
public class MrmBasePersonCommand extends BaseAjaxCommand{
	
	private static final String file_dir = CamsProperties.getString("file_dir");
	
	IMrmBasePersonDomain mrmBasePersonDomain = ScaComponentFactory.getService(
			IMrmBasePersonDomain.class,
			"MrmBasePersonDomain/MrmBasePersonDomain");
	private MrmBasePersonDao dao = (MrmBasePersonDao) DaoFactory
	.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmBasePersonDao");
	private IMrmRegisOrganInfoDomain domain = ScaComponentFactory.getService(
			IMrmRegisOrganInfoDomain.class, "MrmRegisOrganInfoDomain/MrmRegisOrganInfoDomain");
	
	public void getDeptId() {
		String loginId=(String)getParameter("loginId")==null?"":(String)getParameter("loginId");
		String deptId= loginId.substring(0, loginId.length()-3);
		ParameterSet ps = new ParameterSet();
		ps.setParameter("DEPT_CODE@=",deptId);
		DataSet ds=domain.query(ps);
		if(ds.getCount()>0){
			MrmRegisOrganInfo m =(MrmRegisOrganInfo)ds.getRecord(0).toBean(MrmRegisOrganInfo.class);
			setReturn("deptName", m.getName());
		}else{
			setReturn("deptName", "");
			throw new RuntimeException("没有找到相应的婚姻登记处！");
		}
		setReturn("deptId", deptId);
	}
	
	//保存
	@Trans
	public void insert() {
		
		Record MrmBasePersonRecord = (Record) getParameter("MrmBasePerson");
		
		//获取pubOrganId
		EntityDao<MrmRegisOrganInfo> dao1 = (EntityDao<MrmRegisOrganInfo>) DaoFactory
		.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmRegisOrganInfoDao");
		ParameterSet psetdept = new ParameterSet();
		String deptId = (String) MrmBasePersonRecord.get("deptId");
		psetdept.setParameter("DEPT_CODE", deptId);
		DataSet dSet = dao1.query(psetdept);
		String pubOrganId = dSet.getRecord(0).get("pubOrganId").toString();
		MrmBasePerson mrmBasePerson = (MrmBasePerson) MrmBasePersonRecord.toBean(MrmBasePerson.class);
	//	String personId = IdHelp.getUUID32();
	//	mrmBasePerson.setPersonId(personId);
		mrmBasePerson.setParentOrganId(pubOrganId);
		boolean haves=dao.getByLoginId(mrmBasePerson.getLoginid());
		if(haves){
			throw new RuntimeException("该用户已经存在！");
		}else{
			mrmBasePersonDomain.insert(mrmBasePerson);
		}
	}
	
	//保存
	@Trans
	public void insertPerson() {
		Record records = (Record) getParameter("records");
		String organId = (String) getParameter("organId");
		String deptId = (String) getParameter("deptId");
		String deptName = (String) getParameter("deptName");
		MrmBasePerson mrmBasePerson = (MrmBasePerson) records.toBean(MrmBasePerson.class);
		mrmBasePerson.setOrganId(organId);
		mrmBasePerson.setDeptId(deptId);
		mrmBasePerson.setDeptName(deptName);
		String personId = IdHelp.getUUID32();
		mrmBasePerson.setPersonId(personId);
		mrmBasePersonDomain.insertPerson(mrmBasePerson);
	}
	
	//修改
	@Trans
	public void update() {
		Record records = (Record) getParameter("records");
		String personId = (String) getParameter("personId");
		String deptId = (String) getParameter("deptId");
		String deptName = (String) getParameter("deptName");
		MrmBasePerson mrmBasePerson = (MrmBasePerson) records.toBean(MrmBasePerson.class);
//		mrmBasePerson.setDeptId(deptId);
		mrmBasePerson.setPersonId(personId);
		//mrmBasePerson.setDeptName(deptName);
		mrmBasePersonDomain.update(mrmBasePerson);
	}
	//删除
	@Trans
	public void delete() {
		String delIds=(String) getParameter("delIds");
		String[] personId = delIds.split(",");
		for (int i = 0; i < personId.length; i++) {
			String per = personId[i].toString();
			mrmBasePersonDomain.delete(per);
		}
	}
	/**
	 * 设置为颁证员
	 */
	@Trans
	public void bzySet(){
		String delIds=(String) getParameter("delIds");
		String[] personId = delIds.split(",");
		MrmBasePerson mrmBasePerson = new MrmBasePerson();
		mrmBasePerson.setBzyCode("02");//02:颁证员
		for (int i = 0; i < personId.length; i++) {
			String per = personId[i].toString();
			mrmBasePerson.setPersonId(per);
			mrmBasePersonDomain.updateBzy(mrmBasePerson);
		}
	}
	/**
	 * 撤销颁证员
	 */
	@Trans
	public void bzyRevocation(){
		String delIds=(String) getParameter("delIds");
		String[] personId = delIds.split(",");
		MrmBasePerson mrmBasePerson = new MrmBasePerson();
		mrmBasePerson.setBzyCode("01");//01:登记员
		for (int i = 0; i < personId.length; i++) {
			String per = personId[i].toString();
			mrmBasePerson.setPersonId(per);
			mrmBasePersonDomain.updateBzy(mrmBasePerson);
		}
	}
	  
	/**
	 * 上传附件
	 */
	@Trans
	public void saveUpload(){
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		UploadFile uploadFile = wrapRequest.getUploadFile("filename"); // 获得上传的模板
		String fileId = (String) getParameter("fileId"); // 模板主键id
		String personId = (String) getParameter("personId");//人员id
		String suffFileName = (String)getParameter("suffFileName"); //模板后缀名
		
		if (uploadFile != null) { // 如果模板不为空
			if (uploadFile.getFileSize() > 5 * 1024 * 1024) { //设置上传文件最大值
				throw new RuntimeException("附件最大不能超过5M");
			}

			String organCode = BspUtil.getOrganCode();
			String file_domicode = organCode.substring(0, 6); //取行政区划前六位
			String file_name = uploadFile.getFileName(); // 模板名称
			String pathDir = file_dir + "/" + file_domicode;// 上传模板目录
			
			File file = new File(pathDir);
			if (!file.exists()) { // 创建上传模板目录
				file.mkdirs();
			}

			/*********查询是否已存在该地区下的模板**********/
			ParameterSet pset = new ParameterSet(); 
			pset.setParameter("PERSON_ID", personId);
			DataSet ds = mrmBasePersonDomain.query(pset);
			
			MrmBasePerson mrmBasePerson = null;
			mrmBasePerson = (MrmBasePerson) ds.getRecord(0).toBean(MrmBasePerson.class);
			String filePathOld = mrmBasePerson.getFilePath();
			if (filePathOld != null && !"".equals(filePathOld)) { // 已存在该业务类型的模板，则先删除模板
					file = new File(filePathOld);
					if(file.exists()) { // 删除旧模板
						file.delete();
					}
			}

			/*************将模板文件保存到当地硬盘文件并保存数据库信息**************/
			String file_id = IdHelp.getUUID30(); // 模板文件数据库主键
			
			String filePath = pathDir + "/" + file_id + "." + suffFileName; // 模板路径(防止重复)
			file = new File(filePath);
			byte[] buffer = new byte[1024 * 10];
			FileOutputStream out = null;
			InputStream in = null;
			int size = 0;
			try {
				out = new FileOutputStream(file);
				in = uploadFile.getInputStream();
				while ((size = in.read(buffer)) != -1) {
					out.write(buffer,0,size);
					out.flush();
				}
				
				//修改数据库记录
//				MrmBasePerson mrmBasePerson = new MrmBasePerson();
				mrmBasePerson.setPersonId(personId);
				mrmBasePerson.setFilePath(filePath);
				mrmBasePerson.setFileName(file_name);
				mrmBasePersonDomain.update(mrmBasePerson);
			} catch (IOException e) {
				e.printStackTrace();
			} finally { //关闭流
				if (null != in) {
					try {
						in.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (null != out) {
					try {
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	/**
	 * 验证文件是否存在
	 */
	public void ifexeit() {
		String filePath = (String)getParameter("filePath");
		File file = new File(filePath);
		setReturn("exist", file.exists()); 
	}
	
	
	/**
	 * 照片处理(婚登员照片、签名)
	 * @param 
	 */

	public void dealPhotoC(MrmBasePerson mrmBasePerson,String nowTime,String areaCode,String employeeName,String peoplePhotoTemp) {
		// 采集证件照片
		String applybase64Code = "";
		String applyId = "";
		applybase64Code = mrmBasePerson.getPhotoTemp();
		if (null != applybase64Code && !"".equals(applybase64Code)) {
			// 保存图片到表中，并返回该图片的主键
			applyId = PhotoUtil.savePhoto(mrmBasePerson.getPhotoTemp());
		}

		if (applyId != null && !"".equals(applyId)) {
			mrmBasePerson.setPhoto(applyId);
		}

	}	
	/**
	 * 获得photo
	 * 
	 * @param peopleId
	 * @return
	 */
	public String findPhotoId(String personId) {
		IMrmBasePersonDomain service = ScaComponentFactory.getService(
				IMrmBasePersonDomain.class,
				"MrmBasePersonDomain/MrmBasePersonDomain");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PERSON_ID", personId);
		return ((MrmBasePerson) service.query(pset).getRecord(0)
				.toBean(MrmBasePerson.class)).getPhoto();
	}	
	
}
